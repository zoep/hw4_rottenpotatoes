require 'spec_helper'

describe  MoviesController do
  describe 'Find movies with the same director' do
   it 'should return to home page if there is no director' do
     post :index
   end
 end
end
