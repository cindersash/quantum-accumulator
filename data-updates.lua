table.insert(data.raw["technology"]["quantum-processor"].effects, {
  type = "unlock-recipe",
  recipe = "qa_quantum-accumulator"
})

data.raw["accumulator"]["accumulator"].next_upgrade = "qa_quantum-accumulator"
