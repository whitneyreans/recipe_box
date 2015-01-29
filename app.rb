require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  @categories = Category.all()
  erb(:index)
end

post('/recipes') do
  category = params.fetch("category")
  instructions = params.fetch("instructions")
  name = params.fetch("name")
  @category = Category.create({:name => category})
  @recipe = Recipe.create({:name => name, :instruction => instructions })
  redirect '/'
end

get('/recipes/:id') do
  @recipes = Recipe.all()
  @recipe = Recipe.find(params.fetch("id").to_i())
  @ingredients = Ingredient.all()
  erb(:recipes)
end

post('/recipes/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  ingredient = params.fetch("ingredient")
  @ingredient = Ingredient.create({:name => ingredient, :recipe_id => @recipe.id()})
  @ingredients = Ingredient.all()
  redirect "/recipes/#{@recipe.id()}"
end

delete('/') do
  @recipes = Recipe.all()
  recipe_id = params.fetch("recipe_id").to_i()
  Recipe.find(recipe_id).delete()
  redirect "/"
end
