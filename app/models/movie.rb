class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
class Movie::InvalidKeyError < StandardError ; end
  
  Tmdb::Api.key('f4702b08c0ac6ea5b51425788bb26562')
  
    def self.find_in_tmdb(string)
    begin
      moviesRating = ''
      allMovies = [] #Will create an array of hashes
      if Tmdb::Movie.find(string) != nil
        Tmdb::Movie.find(string).each do |m|
          #Get the movie's rating
          Tmdb::Movie.releases(m.id)["countries"].each do |rate|
            #If it's the US rating
            if rate["iso_3166_1"] == "US"
              moviesRating = rate["certification"]
            end
          end
          moviesHash = {:tmdb_id => m.id, :title => m.title, :release_date => m.release_date, :rating => movieRating}
          allMovies.push(moviesHash)
        end
      end
      return allMovies
    rescue Tmdb::InvalidApiKeyError
        raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end
  
  def self.create_tmdb(tmdb_id)
  end

end
