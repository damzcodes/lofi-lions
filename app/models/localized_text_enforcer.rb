class LocalizedTextEnforcer

  #called after a master text is created. Assume no localized texts are created.
  def master_text_created(master_text)
    Language.all.each do |language|
      master_text.localized_texts.create!(language: language)
    end
  end

  #used when a master text is changed. Assume localized texts are all created.
  def master_text_changed(master_text)
    master_text.localized_texts.where('text != ?', '').update_all(needs_review: true)
  end

  def language_created(language)
    MasterText.all.each do |master_text|
      master_text.localized_texts.create!(language: language)
    end
  end

  class MasterTextCrudder
    def initialize(master_text)
      @master_text = master_text
    end

    def save
      was_new_record = @master_text.new_record?
      text_changed = @master_text.text_changed?
      if result=@master_text.save
        if was_new_record
          LocalizedTextEnforcer.new.master_text_created(@master_text)
        elsif text_changed
          LocalizedTextEnforcer.new.master_text_changed(@master_text)
        end
      end
      result
    end

    def update(attrs)
      @master_text.with_transaction_returning_status do
        @master_text.assign_attributes(attrs)
        self.save
      end
    end
  end

  class LanguageCreator
    def initialize(language)
      @language = language
    end

    def save
      if @language.new_record? && @language.save
        LocalizedTextEnforcer.new.language_created(@language)
      end
    end
  end
end