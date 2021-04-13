class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def genre_id=(id)
    self.genre = Genre.find(id)
  end

  def genre_id
    self.genre ? self.genre.id : nil
  end

  def song_notes=(notes)
    
    existing_notes = self.notes.ids
    notes.each_with_index do |note, index|
      if existing_notes[index]
        found_note = Note.find(existing_notes[index])
        found_note.content = notes[index]
        found_note.save
      else
        self.notes << Note.create(content: note)
      end
    end
    #byebug
  end

  def song_notes
    self.notes ? self.notes : nil
  end
end
