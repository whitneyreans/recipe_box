require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all()
  @categories = Category.all()
  erb(:index)
end

post('/recipes') do
  instructions = params.fetch("instructions")
  name = params.fetch("name")
  @recipe = Recipe.create({:name => name, :instruction => instructions })
  redirect '/'
end

get('/recipes/:id') do
  @categories = Category.all()
  @recipes = Recipe.all()
  @recipe = Recipe.find(params.fetch("id").to_i())
  @ingredients = Ingredient.all()
  erb(:recipes)
end

post('/recipes/:id') do
  # category = params.fetch("category")
  # @category = Category.create({:name => category })
  # @categories = Category.all()
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

post('/categories') do
  category = params.fetch("category")
  @recipe = Recipe.fetch()
  url = "/recipes/" + params.fetch('recipe_id')
  redirect(url)
end
