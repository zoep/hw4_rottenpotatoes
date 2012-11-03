require 'spec_helper'

describe Movie do
  describe 'Find movies with the same director' do
    it 'should search for similar movies' do
      fake_results = [mock('Movie'), mock('Movie')] 
      Movie.should_receive(:find_all_by_director).with('Director').and_return(fake_results)
      Movie.find_by_director('Director')
    end
  end
end
