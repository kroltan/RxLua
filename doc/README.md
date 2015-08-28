# Observer

Observers are simple objects that receive values from Observables.

---

#### `.create(onNext, onError, onComplete)`

Creates a new Observer.

Arguments:

- `[onNext]` (`function`) - Called when the Observable produces a value.
- `[onError]` (`function`) - Called when the Observable terminates due to an error.
- `[onComplete]` (`function`) - Called when the Observable completes normally.

Returns:

- `Observer`

---

#### `:onNext(value)`

Pushes a new value to the Observer.

Arguments:

- `value` (`*`)

---

#### `:onError(message)`

Notify the Observer that an error has occurred.

Arguments:

- `[message]` (`string`) - A string describing what went wrong.

---

#### `:onComplete()`

Notify the Observer that the sequence has completed and will produce no more values.

# Observable

Observables push values to Observers.

---

#### `.create(subscribe)`

Creates a new Observable.

Arguments:

- `subscribe` (`function`) - The subscription function that produces values.

Returns:

- `Observable`

---

#### `.fromValue(value)`

Creates an Observable that produces a single value.

Arguments:

- `value` (`*`)

Returns:

- `Observable`

---

#### `.fromRange(initial, limit, step)`

Creates an Observable that produces a range of values in a manner similar to a Lua for loop.

Arguments:

- `initial` (`number`) - The first value of the range, or the upper limit if no other arguments are specified.
- `[limit]` (`number`) - The second value of the range.
- `[step=1]` (`number`) - An amount to increment the value by each iteration.

Returns:

- `Observable`

---

#### `.fromTable(table, iterator)`

Creates an Observable that produces values from a table.

Arguments:

- `table` (`table`) - The table used to create the Observable.
- `[iterator=pairs]` (`function`) - An iterator used to iterate the table, e.g. pairs or ipairs.

Returns:

- `Observable`

---

#### `.fromCoroutine(coroutine)`

Creates an Observable that produces values when the specified coroutine yields.

Arguments:

- `coroutine` (`thread`)

Returns:

- `Observable`

---

#### `:subscribe(onNext, onError, onComplete)`

Shorthand for creating an Observer and passing it to this Observable's subscription function.

Arguments:

- `onNext` (`function`) - Called when the Observable produces a value.
- `onError` (`function`) - Called when the Observable terminates due to an error.
- `onComplete` (`function`) - Called when the Observable completes normally.

---

#### `:dump(name)`

Subscribes to this Observable and prints values it produces.

Arguments:

- `[name]` (`string`) - Prefixes the printed messages with a name.

---

#### `:combineLatest(observables, combinator)`

Returns a new Observable that runs a combinator function on the most recent values from a set of Observables whenever any of them produce a new value. The results of the combinator function are produced by the new Observable.

Arguments:

- `observables` (`Observable...`) - One or more Observables to combine.
- `combinator` (`function`) - A function that combines the latest result from each Observable and returns a single value.

Returns:

- `Observable`

---

#### `:concat(sources)`

Returns a new Observable that produces the values produced by all the specified Observables in the order they are specified.

Arguments:

- `sources` (`Observable...`) - The Observables to concatenate.

Returns:

- `Observable`

---

#### `:distinct()`

Returns a new Observable that produces the values from the original with duplicates removed.

Returns:

- `Observable`

---

#### `:filter(predicate)`

Returns a new Observable that only produces values of the first that satisfy a predicate.

Arguments:

- `predicate` (`function`) - The predicate to filter values with.

Returns:

- `Observable`

---

#### `:first()`

Returns a new Observable that only produces the first result of the original.

Returns:

- `Observable`

---

#### `:last()`

Returns a new Observable that only produces the last result of the original.

Returns:

- `Observable`

---

#### `:map(callback)`

Returns a new Observable that produces the values of the original transformed by a function.

Arguments:

- `callback` (`function`) - The function to transform values from the original Observable.

Returns:

- `Observable`

---

#### `:merge(sources)`

Returns a new Observable that produces the values produced by all the specified Observables in the order they are produced.

Arguments:

- `sources` (`Observable...`) - One or more Observables to merge.

Returns:

- `Observable`

---

#### `:pluck(key)`

Returns a new Observable that produces values computed by extracting the given key from the tables produced by the original.

Arguments:

- `key` (`function`) - The key to extract from the table.

Returns:

- `Observable`

---

#### `:reduce(accumulator, seed)`

Returns a new Observable that produces a single value computed by accumulating the results of running a function on each value produced by the original Observable.

Arguments:

- `accumulator` (`function`) - Accumulates the values of the original Observable. Will be passed the return value of the last call as the first argument and the current value as the second.
- `seed` (`*`) - A value to pass to the accumulator the first time it is run.

Returns:

- `Observable`

---

#### `:skip(n)`

Returns a new Observable that skips over a specified number of values produced by the original and produces the rest.

Arguments:

- `[n=1]` (`number`) - The number of values to ignore.

Returns:

- `Observable`

---

#### `:skipUntil(other)`

Returns a new Observable that skips over values produced by the original until the specified Observable produces a value.

Arguments:

- `other` (`Observable`) - The Observable that triggers the production of values.

Returns:

- `Observable`

---

#### `:sum()`

Returns a new Observable that produces the sum of the values of the original Observable as a single result.

Returns:

- `Observable`

---

#### `:take(n)`

Returns a new Observable that only produces the first n results of the original.

Arguments:

- `[n=1]` (`number`) - The number of elements to produce before completing.

Returns:

- `Observable`

---

#### `:takeUntil(other)`

Returns a new Observable that completes when the specified Observable fires.

Arguments:

- `other` (`Observable`) - The Observable that triggers completion of the original.

Returns:

- `Observable`

# Scheduler

Schedulers manage groups of Observables.

# CooperativeScheduler

Manages Observables using coroutines and a virtual clock that must be updated manually.

---

#### `.create(currentTime)`

Creates a new Cooperative Scheduler.

Arguments:

- `[currentTime=0]` (`number`) - A time to start the scheduler at.

Returns:

- `Scheduler.Cooperative`

---

#### `:schedule(action, delay)`

Schedules a function to be run after an optional delay.

Arguments:

- `action` (`function`) - The function to execute. Will be converted into a coroutine. The coroutine may yield execution back to the scheduler with an optional number, which will put it to sleep for a time period.
- `[delay=0]` (`number`) - Delay execution of the action by a time period.

---

#### `:update(delta)`

Triggers an update of the Cooperative Scheduler. The clock will be advanced and the scheduler will run any coroutines that are due to be run.

Arguments:

- `[delta=0]` (`number`) - An amount of time to advance the clock by. It is common to pass in the time in seconds or milliseconds elapsed since this function was last called.

---

#### `:isEmpty()`

Returns whether or not the Cooperative Scheduler's queue is empty.

# Subject

Subjects function both as an Observer and as an Observable. Subjects inherit all Observable functions, including subscribe. Values can also be pushed to the Subject, which will be broadcasted to any subscribed Observers.

---

#### `.create()`

Creates a new Subject.

Returns:

- `Subject`

---

#### `:subscribe(onNext, onError, onComplete)`

Creates a new Observer and attaches it to the Subject.

Arguments:

- `onNext` (`function`) - Called when the Subject produces a value.
- `onError` (`function`) - Called when the Subject terminates due to an error.
- `onComplete` (`function`) - Called when the Subject completes normally.

---

#### `:onNext(value)`

Pushes a value to the Subject. It will be broadcasted to all Observers.

Arguments:

- `value` (`*`)

---

#### `:onError(message)`

Signal to all Observers that an error has occurred.

Arguments:

- `[message]` (`string`) - A string describing what went wrong.

---

#### `:onComplete()`

Signal to all Observers that the Subject will not produce any more values.
