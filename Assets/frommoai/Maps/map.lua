return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 40,
  height = 25,
  tilewidth = 32,
  tileheight = 32,
  properties = {},
  tilesets = {
    {
      name = "barrel",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "LPC Base Assets/tiles/barrel.png",
      imagewidth = 128,
      imageheight = 64,
      properties = {},
      tiles = {}
    },
    {
      name = "castle_outside",
      firstgid = 9,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "LPC Base Assets/tiles/castle_outside.png",
      imagewidth = 544,
      imageheight = 352,
      properties = {},
      tiles = {}
    },
    {
      name = "dirt",
      firstgid = 196,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "LPC Base Assets/tiles/dirt.png",
      imagewidth = 96,
      imageheight = 192,
      properties = {},
      tiles = {}
    },
    {
      name = "dirt2",
      firstgid = 214,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "LPC Base Assets/tiles/dirt2.png",
      imagewidth = 96,
      imageheight = 192,
      properties = {},
      tiles = {}
    },
    {
      name = "grass",
      firstgid = 232,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "LPC Base Assets/tiles/grass.png",
      imagewidth = 96,
      imageheight = 192,
      properties = {},
      tiles = {}
    },
    {
      name = "grassalt",
      firstgid = 250,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "LPC Assets/LPC Base Assets/tiles/grassalt.png",
      imagewidth = 96,
      imageheight = 192,
      properties = {},
      tiles = {}
    },
    {
      name = "house",
      firstgid = 268,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "LPC Assets/LPC Base Assets/tiles/house.png",
      imagewidth = 288,
      imageheight = 224,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 40,
      height = 25,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        206, 212, 206, 213, 213, 212, 212, 213, 212, 213, 213, 212, 213, 206, 212, 206, 213, 212, 206, 206, 212, 212, 206, 212, 206, 213, 212, 206, 212, 212, 206, 212, 213, 213, 206, 213, 212, 212, 212, 212,
        212, 206, 206, 206, 212, 212, 206, 212, 206, 206, 212, 212, 206, 213, 213, 206, 213, 206, 213, 212, 212, 213, 212, 206, 212, 213, 212, 206, 213, 212, 212, 212, 213, 206, 206, 206, 212, 212, 212, 213,
        206, 213, 206, 212, 213, 206, 213, 206, 213, 206, 213, 212, 213, 213, 206, 212, 212, 212, 213, 206, 212, 213, 206, 213, 212, 213, 213, 213, 213, 213, 212, 213, 206, 213, 213, 213, 212, 212, 213, 212,
        213, 212, 206, 206, 206, 212, 213, 212, 213, 212, 213, 212, 212, 212, 213, 212, 212, 206, 206, 206, 206, 213, 213, 212, 213, 206, 213, 206, 212, 213, 206, 206, 206, 213, 213, 213, 206, 206, 213, 213,
        213, 206, 213, 212, 213, 213, 206, 212, 206, 206, 206, 212, 206, 213, 212, 206, 212, 206, 206, 212, 206, 213, 212, 212, 213, 213, 206, 213, 213, 212, 206, 212, 212, 213, 213, 213, 206, 213, 213, 213,
        213, 206, 213, 206, 213, 212, 206, 206, 212, 212, 213, 212, 213, 206, 212, 206, 206, 206, 213, 212, 212, 212, 213, 212, 206, 212, 212, 206, 206, 206, 212, 213, 206, 206, 213, 206, 206, 213, 213, 212,
        212, 212, 206, 213, 212, 206, 213, 212, 212, 206, 206, 212, 212, 213, 212, 206, 206, 206, 212, 206, 212, 212, 213, 212, 213, 206, 213, 212, 206, 206, 212, 212, 212, 206, 213, 213, 213, 213, 212, 206,
        206, 213, 206, 213, 213, 206, 212, 206, 206, 206, 206, 213, 213, 212, 206, 212, 206, 212, 212, 206, 206, 213, 212, 212, 213, 212, 213, 212, 213, 213, 213, 213, 212, 206, 212, 206, 206, 212, 212, 213,
        206, 213, 213, 213, 213, 212, 206, 212, 213, 206, 212, 206, 212, 206, 213, 213, 206, 212, 206, 213, 213, 212, 206, 213, 206, 212, 213, 213, 206, 213, 212, 212, 212, 212, 213, 213, 213, 213, 206, 206,
        213, 206, 206, 212, 206, 206, 213, 212, 212, 213, 212, 212, 206, 213, 206, 213, 212, 213, 206, 212, 212, 212, 212, 212, 206, 212, 206, 213, 213, 212, 212, 213, 212, 206, 206, 212, 212, 206, 213, 212,
        213, 206, 213, 206, 206, 213, 213, 206, 212, 212, 213, 206, 213, 212, 212, 206, 206, 206, 213, 213, 206, 212, 206, 213, 212, 213, 206, 206, 213, 213, 212, 206, 212, 206, 212, 213, 206, 212, 206, 213,
        213, 212, 212, 206, 213, 212, 206, 212, 213, 206, 213, 213, 206, 206, 213, 213, 212, 212, 212, 206, 213, 212, 212, 213, 206, 212, 206, 212, 213, 212, 206, 206, 213, 206, 212, 212, 213, 206, 212, 206,
        212, 213, 213, 212, 206, 212, 206, 212, 212, 212, 213, 213, 212, 206, 213, 206, 212, 213, 212, 213, 213, 213, 213, 212, 213, 212, 213, 206, 206, 213, 213, 206, 206, 212, 206, 212, 212, 212, 212, 213,
        212, 206, 213, 213, 206, 212, 213, 212, 213, 213, 212, 212, 206, 212, 206, 206, 213, 206, 206, 213, 212, 212, 213, 206, 213, 213, 206, 206, 213, 212, 206, 212, 212, 213, 213, 206, 212, 213, 206, 213,
        206, 212, 206, 213, 213, 206, 206, 206, 206, 212, 206, 212, 206, 212, 206, 212, 213, 212, 206, 213, 212, 206, 213, 212, 206, 213, 206, 206, 213, 213, 213, 212, 212, 212, 206, 206, 212, 213, 212, 206,
        213, 213, 206, 206, 206, 213, 213, 213, 212, 213, 212, 213, 206, 212, 212, 213, 212, 206, 213, 206, 213, 206, 212, 206, 213, 212, 212, 213, 206, 206, 206, 206, 212, 212, 212, 206, 206, 206, 206, 212,
        206, 206, 206, 213, 206, 212, 212, 212, 213, 212, 213, 212, 206, 212, 213, 212, 206, 206, 206, 206, 213, 213, 212, 213, 213, 213, 206, 206, 212, 213, 212, 213, 213, 213, 213, 212, 206, 206, 213, 206,
        212, 213, 213, 212, 206, 206, 206, 206, 212, 206, 213, 206, 212, 213, 213, 213, 213, 206, 213, 212, 213, 213, 212, 212, 212, 212, 212, 213, 213, 213, 206, 212, 213, 213, 212, 206, 206, 206, 213, 213,
        212, 206, 206, 213, 213, 206, 213, 213, 206, 206, 213, 213, 206, 206, 213, 212, 212, 212, 206, 212, 212, 212, 212, 213, 213, 212, 213, 212, 212, 206, 212, 213, 213, 212, 213, 213, 206, 206, 213, 212,
        206, 212, 206, 206, 206, 206, 212, 212, 206, 213, 213, 213, 206, 206, 213, 206, 213, 213, 206, 213, 213, 213, 213, 212, 212, 213, 206, 212, 212, 206, 212, 206, 212, 206, 212, 212, 212, 206, 213, 206,
        213, 213, 206, 212, 212, 212, 212, 212, 213, 206, 212, 212, 212, 212, 213, 206, 212, 206, 206, 213, 212, 213, 206, 213, 213, 213, 213, 212, 213, 206, 213, 206, 206, 213, 213, 212, 212, 206, 206, 206,
        213, 212, 206, 212, 213, 213, 206, 213, 213, 206, 212, 206, 213, 206, 206, 213, 213, 206, 213, 212, 213, 213, 206, 206, 213, 212, 212, 206, 213, 206, 213, 206, 213, 213, 213, 206, 212, 206, 212, 206,
        213, 213, 206, 206, 213, 212, 212, 212, 206, 206, 212, 206, 212, 206, 213, 213, 212, 212, 206, 212, 206, 206, 212, 212, 212, 206, 206, 212, 206, 206, 213, 213, 212, 212, 212, 213, 206, 206, 213, 212,
        213, 212, 206, 213, 206, 212, 212, 213, 206, 213, 213, 206, 212, 213, 206, 213, 213, 213, 206, 212, 212, 212, 212, 212, 206, 213, 206, 213, 213, 212, 212, 206, 212, 212, 213, 213, 206, 206, 213, 213,
        206, 206, 206, 212, 212, 213, 212, 213, 212, 213, 212, 206, 212, 206, 212, 206, 206, 212, 206, 206, 206, 213, 212, 206, 213, 206, 206, 213, 213, 213, 206, 206, 213, 212, 213, 206, 213, 213, 212, 206
      }
    },
    {
      type = "tilelayer",
      name = "Tile Layer 2",
      x = 0,
      y = 0,
      width = 40,
      height = 25,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        248, 249, 247, 248, 247, 242, 247, 242, 242, 248, 247, 249, 242, 247, 249, 242, 249, 247, 242, 247, 249, 243, 0, 0, 0, 0, 0, 0, 0, 238, 239, 237, 248, 249, 249, 242, 242, 242, 242, 249,
        248, 242, 249, 242, 247, 247, 249, 247, 249, 248, 249, 249, 249, 248, 247, 249, 248, 242, 248, 247, 233, 246, 0, 0, 0, 0, 0, 0, 0, 241, 247, 249, 242, 247, 248, 242, 247, 242, 248, 248,
        242, 242, 242, 247, 242, 248, 249, 247, 248, 249, 249, 249, 249, 247, 247, 242, 249, 242, 233, 245, 246, 0, 0, 0, 0, 0, 0, 0, 238, 237, 249, 248, 242, 249, 249, 249, 249, 242, 242, 249,
        249, 247, 242, 248, 242, 248, 248, 248, 242, 249, 242, 249, 248, 247, 247, 247, 248, 233, 246, 0, 0, 0, 0, 0, 0, 0, 0, 238, 237, 242, 247, 242, 242, 242, 242, 248, 242, 242, 248, 242,
        242, 247, 249, 247, 249, 249, 249, 242, 248, 247, 249, 242, 249, 248, 248, 249, 233, 246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241, 249, 249, 249, 247, 247, 248, 242, 247, 247, 248, 249, 242,
        242, 247, 242, 242, 249, 249, 242, 247, 249, 248, 242, 247, 247, 249, 247, 233, 246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 238, 237, 248, 242, 247, 247, 247, 249, 242, 248, 248, 247, 248, 249,
        242, 247, 249, 242, 242, 247, 248, 248, 247, 247, 248, 242, 249, 249, 233, 246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241, 249, 247, 242, 247, 247, 242, 249, 247, 248, 247, 247, 249, 247,
        249, 247, 247, 248, 247, 242, 249, 247, 248, 249, 248, 247, 242, 247, 243, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 238, 237, 249, 248, 248, 248, 247, 247, 247, 242, 242, 247, 249, 242, 248,
        247, 248, 247, 249, 248, 249, 248, 247, 247, 242, 242, 247, 247, 233, 246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241, 249, 242, 247, 242, 247, 242, 242, 247, 248, 248, 247, 242, 249, 248,
        247, 248, 249, 248, 248, 247, 249, 242, 249, 247, 242, 233, 245, 246, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 238, 237, 248, 248, 242, 247, 248, 248, 247, 247, 242, 247, 249, 242, 242, 248,
        248, 249, 247, 248, 242, 248, 249, 248, 247, 249, 233, 246, 0, 0, 0, 0, 0, 238, 239, 239, 240, 0, 0, 0, 241, 247, 248, 247, 249, 248, 249, 247, 249, 249, 242, 242, 247, 242, 249, 249,
        248, 248, 242, 242, 249, 242, 249, 242, 233, 245, 246, 0, 0, 0, 0, 0, 238, 237, 248, 249, 243, 0, 0, 0, 241, 248, 249, 249, 242, 249, 249, 242, 242, 247, 248, 248, 247, 242, 249, 242,
        247, 249, 248, 249, 249, 242, 233, 245, 246, 0, 0, 0, 0, 238, 239, 239, 237, 242, 247, 242, 243, 0, 0, 0, 244, 234, 247, 242, 249, 247, 248, 249, 249, 248, 242, 242, 247, 249, 242, 247,
        249, 247, 247, 233, 245, 245, 246, 0, 0, 0, 0, 0, 0, 241, 248, 247, 249, 249, 249, 247, 243, 0, 0, 0, 0, 241, 249, 249, 247, 247, 242, 247, 249, 249, 247, 247, 248, 249, 249, 242,
        245, 245, 245, 246, 0, 0, 0, 0, 0, 0, 238, 239, 239, 237, 248, 249, 247, 249, 249, 249, 243, 0, 0, 0, 238, 237, 242, 242, 249, 249, 248, 249, 248, 242, 242, 247, 249, 249, 248, 242,
        0, 0, 0, 0, 0, 0, 0, 0, 238, 239, 237, 249, 249, 247, 247, 242, 242, 248, 248, 247, 243, 0, 0, 0, 241, 248, 242, 242, 249, 249, 248, 242, 248, 247, 248, 249, 242, 242, 248, 242,
        0, 0, 0, 0, 0, 238, 239, 239, 237, 249, 248, 248, 249, 242, 248, 247, 247, 242, 249, 247, 243, 0, 0, 0, 241, 242, 242, 247, 248, 249, 249, 248, 242, 249, 242, 247, 249, 248, 247, 242,
        239, 239, 239, 239, 239, 237, 242, 248, 242, 247, 249, 242, 248, 247, 247, 249, 249, 247, 249, 249, 243, 0, 0, 0, 241, 247, 247, 247, 247, 242, 248, 247, 248, 249, 249, 247, 248, 242, 248, 247,
        249, 247, 248, 242, 248, 249, 247, 249, 248, 242, 247, 247, 247, 248, 242, 249, 248, 248, 247, 249, 243, 0, 0, 0, 241, 242, 249, 242, 242, 247, 242, 242, 248, 248, 248, 247, 247, 248, 248, 248,
        242, 247, 247, 242, 247, 242, 248, 242, 249, 249, 242, 242, 242, 249, 248, 242, 247, 248, 248, 247, 243, 0, 0, 0, 241, 247, 242, 247, 242, 242, 248, 248, 242, 247, 248, 247, 242, 247, 242, 247,
        247, 242, 249, 249, 249, 248, 248, 242, 249, 247, 242, 247, 242, 242, 247, 249, 249, 242, 248, 248, 243, 0, 0, 0, 244, 234, 247, 242, 248, 249, 247, 248, 242, 247, 248, 242, 248, 242, 242, 249,
        249, 242, 247, 249, 248, 247, 249, 248, 242, 248, 248, 249, 249, 247, 249, 242, 247, 249, 247, 242, 243, 0, 0, 0, 0, 241, 247, 249, 248, 247, 249, 249, 248, 247, 248, 249, 249, 242, 249, 249,
        248, 242, 242, 247, 247, 247, 247, 247, 248, 249, 242, 247, 247, 248, 242, 249, 248, 249, 242, 247, 243, 0, 0, 0, 0, 241, 249, 249, 248, 247, 249, 247, 247, 247, 247, 247, 247, 247, 248, 247,
        249, 249, 249, 247, 249, 247, 249, 249, 247, 242, 242, 248, 249, 249, 247, 248, 247, 247, 247, 249, 243, 0, 0, 0, 0, 241, 242, 248, 248, 247, 242, 247, 249, 249, 249, 242, 247, 248, 242, 249,
        248, 242, 249, 242, 247, 242, 242, 248, 248, 249, 248, 248, 242, 248, 249, 248, 242, 247, 248, 249, 243, 0, 0, 0, 0, 244, 234, 248, 247, 247, 247, 242, 248, 249, 242, 242, 247, 247, 249, 247
      }
    },
    {
      type = "tilelayer",
      name = "Tile Layer 3",
      x = 0,
      y = 0,
      width = 40,
      height = 25,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "barrel1",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 160,
          width = 32,
          height = 64,
          visible = true,
          properties = {}
        },
        {
          name = "SpawnPoint",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 736,
          width = 32,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "barrel2",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 640,
          width = 32,
          height = 32,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
