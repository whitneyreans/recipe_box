require('spec_helper')


describe(Recipe) do
  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:ingredients) }

  describe("#ingredients") do
    it("should return the ingredients in the recipe") do
      recipe = Recipe.create({:name => "sandwhich", :instruction => "make it"})
      ingredient = Ingredient.create({:name => "bread", :recipe_id => recipe.id()})
      ingredient2 = Ingredient.create({:name => "otherstuff", :recipe_id => recipe.id()})
      expect(recipe.ingredients()).to(eq([ingredient, ingredient2]))
    end
  end
end
