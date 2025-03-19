function [tresponse Thrhm maxT] = metrics(t, T)

maxT = max(T);

id2 = find(abs(T- max(T)/2)/max(T)  < 1e-2  ,1, 'first');
tresponse = t(id2);
Thrhm = T(id2);

end