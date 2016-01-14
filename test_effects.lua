-- Speed monoid
monoidal_effects.register_monoid("monoidal_effects:speed",
				 { combine = function(x, y) return x * y end,
				   fold = function(elems)
					   local res = 1
					   for k, v in pairs(elems) do
						   res = res * v
					   end

					   return res
				   end,
				   identity = 1,
				   apply = function(mult, player)
					   player:set_physics_override(
						   { speed = mult
					   })
				   end,
				   on_change = function(m1, m2, player)
					   minetest.chat_send_all(m1.." boop "..m2)
				   end,
})


-- Static half speed
monoidal_effects.register_type("monoidal_effects:half_speed",
			       { disp_name = "Half Speed",
				 tags = "test",
				 monoids = "monoidal_effects:speed",
				 cancel_on_death = true,
				 values = { ["monoidal_effects:speed"] = 0.5 },
})


minetest.register_on_joinplayer(function(player)

		monoidal_effects.apply_effect("monoidal_effects:half_speed",
					      10,
					      player:get_player_name()
		)
end)
