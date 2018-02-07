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

## Rename table:

~~~javascript
'use strict';

module.exports = {
  up: function (queryInterface, Sequelize) {
    return queryInterface.renameTable('old_name', 'new_name')
  },

  down: function (queryInterface, Sequelize) {
    return queryInterface.renameTable('new_name', 'old_name')
  }
};
~~~

## Rename column:

~~~javascript
'use strict';

module.exports = {
  up: function (queryInterface, Sequelize) {
    return queryInterface.renameColumn('scenarios', 'old_name', 'new_name')
  },

  down: function (queryInterface, Sequelize) {
    return queryInterface.renameColumn('scenarios', 'new_name', 'old_name')
  }
};
~~~

## Add column:

~~~javascript
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

## Change column:

~~~javascript
'use strict';

module.exports = {
  up: function (queryInterface, Sequelize) {
    return queryInterface.changeColumn(
      'schools',
      'meshblock_code',
      {
        type: Sequelize.BIGINT,
        allowNull: true,
        references: {
          model: 'meshblocks',
          key: 'meshblock_code'
        },
        onUpdate: 'cascade',
        onDelete: 'cascade'
      }
    )
  },

  down: function (queryInterface, Sequelize) {
    return queryInterface.changeColumn(
      'schools',
      'meshblock_code',
      {
        type: Sequelize.BIGINT,
        allowNull: true,
      }
    )
  }
};

~~~

## Execute some SQL:

~~~javascript
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

## Execute some other code to update records in a migration, using model classes:

~~~javascript
'use strict';
const models = require('../models');
const Promise = require('bluebird');
const interventionCrud = require('../modules/interventionCrud');

module.exports = {
  up: async function(queryInterface, Sequelize) {
    // Find all interventions and calcDerivedInterventionFields
    const interventions = await models.intervention.findAll();
    // Updating with no changes will re-calc all derived fields
    await Promise.map(interventions, i => interventionCrud.update(i.id, {}));
  },

  down: function(queryInterface, Sequelize) {
    /*
      Intentionally blank
    */
  },
};

~~~

## Create new record

~~~javascript
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

~~~javascript
const baseScenario = yield models.scenario.findOne({ where: { cluster_id: cluster.id, type }})
~~~

## Find all

~~~javascript
const clusters = yield models.cluster.findAll()
~~~

~~~javascript
const Op = models.Sequelize.Op;
const scenarios = await models.scenario.findAll({
  where: { id: { [Op.in]: ids } },
  include: [
    { model: models.cluster },
    {
      model: models.school,
      include: [models.intervention],
    },
  ],
});
~~~