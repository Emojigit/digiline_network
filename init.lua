local net_nodename = "digiline_network:network_card"
minetest.register_node(net_nodename,{
  description = "Network Card",
  drawtype = "nodebox",
  tiles = {
    "jeija_microcontroller_top.png",
    "jeija_microcontroller_bottom.png",
    "jeija_microcontroller_sides.png",
    "jeija_microcontroller_sides.png",
    "jeija_microcontroller_sides.png",
    "jeija_microcontroller_sides.png"
  },
  inventory_image = "jeija_microcontroller_top.png",
  paramtype = "light",
  is_ground_content = false,
  sunlight_propagates = true,
  selection_box = {
    type = "fixed",
    fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
  },
  node_box = {
    type = "fixed",
    fixed = {
      { -8/16, -8/16, -8/16, 8/16, -7/16, 8/16 }, -- bottom slab
      { -5/16, -7/16, -5/16, 5/16, -6/16, 5/16 }, -- circuit board
      { -3/16, -6/16, -3/16, 3/16, -5/16, 3/16 }, -- IC
    }
  },
  digiline = {
  	receptor = {},
  	effector = {
  		action = function(pos, node, channel, msg)
  			if not(channel == "network") or not(type(msg) == "table") then
          return
        end
        if not msg.to then return end
        local sending = table.copy(msg)
        sending.from = pos
        if type(sending.to.x) == "number" and type(sending.to.y) == "number" and type(sending.to.z) == "number" then
          if minetest.get_node(sending.to).name == net_nodename then
            digilines.receptor_send(sending.to, digilines.rules.default, "network", sending)
          end
        end
  		end
  	}
  },
})
