/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_2153001328")

  // update field
  collection.fields.addAt(8, new Field({
    "help": "false",
    "hidden": false,
    "id": "bool1274995040",
    "name": "registered",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "bool"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_2153001328")

  // update field
  collection.fields.addAt(8, new Field({
    "help": "false",
    "hidden": false,
    "id": "bool1274995040",
    "name": "registered",
    "presentable": false,
    "required": true,
    "system": false,
    "type": "bool"
  }))

  return app.save(collection)
})
