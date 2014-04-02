require 'spec_helper'

describe Category do
  it "is not created without name" do
    category = Category.create
    
    expect(category).not_to be_valid
    expect(Category.count).to eq(0)
  end

  it "is created when has name" do
    category = Category.create name:"testic"
    
    expect(category).to be_valid
    expect(Category.count).to eq(1)
  end
end
