describe('elementAt', function()
  it('errors when its parent errors', function()
    expect(Rx.Observable.throw():elementAt(1).subscribe).to.fail()
  end)

  it('chains subscriptions', function()
    local subscription = Rx.Subscription.create()
    local observable = Rx.Observable.create(function() return subscription end)
    expect(observable:subscribe()).to.equal(subscription)
    expect(observable:elementAt(1):subscribe()).to.equal(subscription)
  end)

  it('errors if no index is specified', function()
    expect(Rx.Observable.of(1):elementAt().subscribe).to.fail()
  end)

  it('produces no values if the specified index is less than one', function()
    expect(Rx.Observable.of(1):elementAt(0)).to.produce.nothing()
    expect(Rx.Observable.of(1):elementAt(-1)).to.produce.nothing()
  end)

  it('produces no values if the specified index is greater than the number of elements produced by the source', function()
    expect(Rx.Observable.of(1):elementAt(2)).to.produce.nothing()
  end)

  it('produces all values produced by the source at the specified index', function()
    local observable = Rx.Observable.create(function(observer)
      observer:onNext(1, 2, 3)
      observer:onNext(4, 5, 6)
      observer:onCompleted()
    end)

    expect(observable:elementAt(2)).to.produce({{4, 5, 6}})
  end)
end)
