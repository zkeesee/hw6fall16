require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
    #If the search was non-blank
    describe 'valid search' do
      it 'should select the Search Results template for rendering' do
        allow(Movie).to receive(:find_in_tmdb)
        post :search_tmdb, {:search_terms => 'Terminator'}
        expect(response).to render_template('search_tmdb')
      end
      
      it 'should make the TMDb search results available to that template' do
        fake_results = [double('Movie'), double('Movie')]
        allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
        post :search_tmdb, {:search_terms => 'Terminator'}
        expect(assigns(:movies)).to eq(fake_results)
      end 
    end
    
    #If the search was blank
    describe 'invalid search' do
      it 'should return to the homepage and flash Invalid search term' do
        post :search_tmdb, {:search_terms => ''}
        expect(response).to redirect_to(movies_path)
        expect(flash[:notice]).to match(/Invalid search term*/)
      end
    end
    
    #If the search was garbage
    describe 'nothing returns' do
      it 'should return to the homepage and print No matching movies were found on TMDb' do
        post :search_tmdb, {:search_terms => 'asdfjklashdfjashdfasdf22342frf'}
        expect(response).to redirect_to(movies_path)
        expect(flash[:notice]).to match(/No matching movies were found on TMDb*/)
      end
    end
  end
  
end