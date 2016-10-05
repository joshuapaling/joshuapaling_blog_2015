---
title: Sequelize
---

<h1>Sequelize</h1>

~~~
sequelize db:migrate
sequelize db:migrate:undo
sequelize db:migrate:undo:all
~~~

[http://docs.sequelizejs.com/en/latest/docs/migrations/](http://docs.sequelizejs.com/en/latest/docs/migrations/)

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
      other_table_id: {
        type: Sequelize.BIGINT,
        allowNull: false,
        references: {
          model: 'clusters',
          key: 'id'
        },
        onUpdate: 'cascade',
        onDelete: 'cascade'
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
    }).then(() => queryInterface.addIndex(
      'scenario_school_years',
      ['scenario_id', 'school_code', 'school_year'],
      {
        indexName: 'unique_scenario_school_years',
        indicesType: 'UNIQUE'
      }
    ))
  },
  down: function(queryInterface, Sequelize) {
    return queryInterface.dropTable('clusters')
  }
}

~~~

## Rename column:

~~~
'use strict';

module.exports = {
  up: function (queryInterface, Sequelize) {
    return queryInterface.renameColumn('scenarios', 'azure_job_status', 'last_azure_job_status')
  },

  down: function (queryInterface, Sequelize) {
    return queryInterface.renameColumn('scenarios', 'last_azure_job_status', 'azure_job_status')
  }
};
~~~

## Add column:

~~~
'use strict';

module.exports = {
  up: function (queryInterface, Sequelize) {
    return queryInterface.addColumn(
      'scenarios',
      'azure_job_status',
      {
        allowNull: false,
        defaultValue: '',
        type: Sequelize.STRING,
        comment: "The status of azure_job_id from Azure's machine learning"
      }
    )
  },

  down: function (queryInterface, Sequelize) {
    return queryInterface.removeColumn('scenarios', 'azure_job_status')
  }
};
~~~

## Create new record

~~~
yield models.scenario_meshblock_result.create({
  result_year: 2016,
  meshblock_code: '1234',
  school_code: '10011670000',
  scenario_id: scenario.id,
  allocated_students: 100,
})
~~~
