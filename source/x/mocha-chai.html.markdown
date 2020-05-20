---
title: Mocha / Chai
---

<h1>Mocha / Chai</h1>

Asset error is thrown in async code:

~~~
const chai = require('chai')
const chaiAsPromised = require('chai-as-promised');
chai.use(chaiAsPromised);

it("throws if you try to refund money you don't have", async function(){
  const orderId = uuidv4()
  const refund_amount = 1

  await expect(calculateRefundBuckets(orderId, refund_amount))
    .to.be.rejectedWith("can't refund money we don't have")
})
~~~


Assert error is thrown in sync code:

~~~
expect(calculateRefundBuckets.bind(calculateRefundBuckets,payments, refund_amount)).to.throw()
~~~
