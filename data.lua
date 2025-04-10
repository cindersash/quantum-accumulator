require("graphics")
require ("circuit-connector-sprites")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")

local quantum_accumulator_prototype = {
    type = "accumulator",
    name = "qa_quantum-accumulator",
    icon = "__quantum-accumulator__/graphics/entity/quantum-accumulator.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "qa_quantum-accumulator"},
    fast_replaceable_group = "qa_quantum-accumulator",
    max_health = 250,
    corpse = "accumulator-remnants",
    dying_explosion = "accumulator-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box_vertical_extension = 0.5,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "50MJ",
      usage_priority = "tertiary",
      input_flow_limit = "10MW",
      output_flow_limit = "10MW"
    },
    chargable_graphics =
    {
      picture = quantum_accumulator_picture(),
      charge_animation = quantum_accumulator_charge(),
      charge_cooldown = 30,
      discharge_animation = quantum_accumulator_discharge(),
      discharge_cooldown = 60
      --discharge_light = {intensity = 0.7, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
    },
    water_reflection = accumulator_reflection(),
    impact_category = "metal",
    open_sound = sounds.electric_large_open,
    close_sound = sounds.electric_large_close,
    working_sound =
    {
      main_sounds =
      {
        {
          sound =
          {
            filename = "__base__/sound/accumulator-working.ogg",
            volume = 0.4,
            modifiers = volume_multiplier("main-menu", 1.44),
            audible_distance_modifier = 0.5
          },
          match_volume_to_activity = true,
          activity_to_volume_modifiers = {offset = 2, inverted = true},
          fade_in_ticks = 4,
          fade_out_ticks = 20
        },
        {
          sound =
          {
            filename = "__base__/sound/accumulator-discharging.ogg",
            volume = 0.4,
            modifiers = volume_multiplier("main-menu", 1.44),
            audible_distance_modifier = 0.5
          },
          match_volume_to_activity = true,
          activity_to_volume_modifiers = {offset = 1},
          fade_in_ticks = 4,
          fade_out_ticks = 20
        }
      },
      idle_sound = {filename = "__base__/sound/accumulator-idle.ogg", volume = 0.35, audible_distance_modifier = 0.5},
      max_sounds_per_prototype = 3,
    },

    circuit_connector = circuit_connector_definitions["accumulator"],
    circuit_wire_max_distance = 9,

    default_output_signal = {type = "virtual", name = "signal-A"}
}

local quantum_accumulator_item = {
    type = "item",
    name = "qa_quantum-accumulator",
    icon = "__quantum-accumulator__/graphics/icons/quantum-accumulator.png",
    subgroup = "energy",
    order = "e[accumulator]-a[accumulator]",
    inventory_move_sound = item_sounds.electric_large_inventory_move,
    pick_sound = item_sounds.electric_large_inventory_pickup,
    drop_sound = item_sounds.electric_large_inventory_move,
    place_result = "qa_quantum-accumulator",
    stack_size = 50
}

local quantum_accumulator_recipe = {
    type = "recipe",
    name = "qa_quantum-accumulator",
    category = "electronics-or-assembling",
    energy_required = 10,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "holmium-plate", amount = 2},
      {type = "item", name = "superconductor", amount = 2},
      {type = "item", name = "quantum-processor", amount = 1}
    },
    results = {{type="item", name="qa_quantum-accumulator", amount=1}}
}

data:extend({quantum_accumulator_prototype, quantum_accumulator_item, quantum_accumulator_recipe})
