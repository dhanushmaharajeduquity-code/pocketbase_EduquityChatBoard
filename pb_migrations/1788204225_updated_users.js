/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("_pb_users_auth_")

  // add field
  collection.fields.addAt(11, new Field({
    "help": "",
    "hidden": false,
    "id": "number2328728453",
    "max": null,
    "min": null,
    "name": "last_seen_ms",
    "onlyInt": false,
    "presentable": false,
    "required": false,
    "system": false,
    "type": "number"
  }))

  // update field
  collection.fields.addAt(9, new Field({
    "help": "",
    "hidden": false,
    "id": "date846843460",
    "max": "",
    "min": "",
    "name": "last_seen",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "date"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("_pb_users_auth_")

  // remove field
  collection.fields.removeById("number2328728453")

  // update field
  collection.fields.addAt(9, new Field({
    "help": "",
    "hidden": false,
    "id": "date846843460",
    "max": "",
    "min": "",
    "name": "last_seen_ms",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "date"
  }))

  return app.save(collection)
})
