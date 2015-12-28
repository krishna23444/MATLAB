load -ascii pen_A
load -ascii uniCD

[N, m] = size(pen_A);

class = N

app  = pen_A;size(app)
test = uniCD;size(test)

Napp = size(app,2);
Ntest = size(test,2);

unique(app(class,:))
unique(test(class,:))

ns1 = max(pen_A');
ns2 = max(uniCD');
ns = max(ns1, ns2)
clear pen_A uniCD ns1 ns2

% N, ns(class), Napp, Ntest, mean(ns),