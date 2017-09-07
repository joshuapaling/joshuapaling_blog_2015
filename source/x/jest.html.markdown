---
title: Jest
---

<h1>Jest</h1>

Example test with mocks

~~~javascript
const { factory } = require('test/helpers/jest');

//////////////////////////////////
// THE MOCK MUST BE ABOVE ALL OTHER CODE
//////////////////////////////////

jest.mock('./avgKmsByAllocatedStudentsPerYear', () => {
  return jest.fn().mockReturnValue({
    2015: 4,
    2016: 2,
  });
});

const averageTravelDistanceByYear = require('./averageTravelDistanceByYear');

describe('averageTravelDistanceByYear', () => {
  it.only(
    'works with data from multiple meshblocks and schools; respects weighting based on allocated_students',
    async function() {
      const scenario = await factory.create('scenario', {
        start_year: 2015,
      });

      const result = await averageTravelDistanceByYear(scenario);
      const expected = {
        2015: (4 * 100 + 10 * 50) / (100 + 50),
        2016: (2 * 150 + 5 * 60) / (150 + 60),
      };
      expect(result[2015]).toBe(expected[2015]);
      expect(result[2016]).toBe(expected[2016]);
    }
  );
});
