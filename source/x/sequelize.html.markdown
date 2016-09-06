---
title: Sequelize
---

<h1>Sequelize</h1>

new migration: `sequelize migration:create` (name it after creating it)

Example migration:

~~~javascript
module.exports = {
  up: function(queryInterface, Sequelize) {
    return queryInterface.createTable('clusters', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.BIGINT
      },
      code: {
        allowNull: false,
        type: Sequelize.STRING,
        unique: true,
      },
      name: {
        allowNull: false,
        type: Sequelize.STRING
      },
      topojson: {
        allowNull: true,
        type: Sequelize.TEXT
      },
      created_at: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updated_at: {
        allowNull: false,
        type: Sequelize.DATE
      }
    })
  },
  down: function(queryInterface, Sequelize) {
    return queryInterface.dropTable('clusters')
  }
}

~~~