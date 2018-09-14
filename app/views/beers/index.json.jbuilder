json.beers do
  json.array! @beers, partial: 'beer', as: :beer
end
