function met = metrics(time, Thrombin)

[maxT, id] = max(T);

id2 = find(abs(T- max(T)/2)/max(T)  < 1e-2  ,2, 'first');
tresponse = t(id2)
Thrhm = T(id2)

met = [ tresponse, Thrhm, maxT]
end