# Test too much nesting

If you try, DITA is infinitely nestable in a number of ways.
Even if you don't actually hit infinity you can go too far for
a lot of customizations that might not anticipate more than
(for example) 5 levels of topic nesting, 4 levels of unordered lists,
or 2 levels of definition lists. 

This test case just takes some of that to extremes to ensure that
builds do not fail or result in undesireable errors. 