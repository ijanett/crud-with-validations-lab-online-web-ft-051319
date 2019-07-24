class Song < ApplicationRecord
    validates_presence_of :title, :artist_name, :genre
    validates :title, uniqueness: {scope: [:artist_name, :release_year] }
    validates :released, inclusion: { in: [true, false] }
    validate :valid_release_year
    
    def valid_release_year
        if released == false
            false
        else
            if release_year.blank?
                errors.add(:release_year, "must not be blank")
            elsif release_year > Time.current.year
                errors.add(:release_year, "must not be future year")
            end
        end
    end
end