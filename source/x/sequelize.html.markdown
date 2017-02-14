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

## Execute some SQL:

~~~
'use strict';

module.exports = {
  up: function (queryInterface, Sequelize) {
    return queryInterface.sequelize.query("insert into settings (setting_key, setting_value) values ('power_bi_url', 'https://app.powerbi.com/groups/3721a85d-41c6-45e9-8a65-2669ee462b47/dashboards/3eeed953-09a6-4713-bf8c-66ec46b8af56')")
  },

  down: function (queryInterface, Sequelize) {
    return queryInterface.sequelize.query("delete from settings where setting_key = 'power_bi_url'")
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

# [find doco](http://docs.sequelizejs.com/en/latest/api/model/#findalloptions-promisearrayinstance)


## Find one

~~~
const baseScenario = yield models.scenario.findOne({ where: { cluster_id: cluster.id, type }})
~~~

## Find all

~~~
const clusters = yield models.cluster.findAll()
~~~