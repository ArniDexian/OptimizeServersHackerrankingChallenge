# Hackerranking challenge 'Optimise servers'

## Challenge description:

While investigating a latency issue on the <A company>, you found out that some of our servers are saturated with multiple requests from the same users. To solve the issue, you decide to implement an algorithm to reject requests from users that send too many of them.
For simplicity, you can assume that a request to the server is represented as a string containing the request **id, ip_address** and the **unix_timestamp_in_milliseconds** separated by whitespaces. We want to assign an integer limit of **limit_per_second** requests accepted per second per IP address. In other words, the server should accept at most **limit_per_second** requests per second from each IP address. Any extraneous requests should be rejected.
Your task is to write a function **GetRejectedRequests** to compute and return the list of requests that should be rejected by our servers. Your function will be called with a list of requests (represented as a list of strings, sorted by timestamp) and the limit
**limit_per_second** (represented as an integer). The returned list should be a list of **request ids** (integers) in chronological order i.e. the timestamp for the corresponding requests should be in nondecreasing order. If two requests in the returned list have the same timestamp, please keep them in the same relative order as they appear in the input. If no requests are rejected, please return an empty list.

### Example 1

**requests**: 
```
[
    "1 172.253.115.138 50000", 
    "2 172.253.115.139 50100", 
    "3 172.253.115.138 50210", 
    "4 172.253.115.139 50300", 
    "5 172.253.115.138 51000",
    "6 172.253.115.139 60300"
]
```
**limit_per_second**: 1

The third request and the first request are from the same IP and only 210ms apart. Therefore, the third request should be rejected. The fifth request, also with the same IP, is not rejected since 1000ms (i.e. 1 second) has elapsed since the last accepted (i.e. first) request, so we can accept this request.
The fourth request and the second request are also from the same IP and only 200ms apart. The second request must be accepted as it is the first from this IP address. Therefore, we must reject the fourth request.
The expected answer is therefore the request ids of the third and fourth request i.e. **[3, 4]**


### Example 2

**requests**: 
```
[
    "10 172.253.115.138 50000", 
    "20 172.253.115.138 50000", 
    "30 172.253.115.138 50000"
]
```
**limit_per_second**: 2

In this case, all requests have the same IP address and timestamp. We will process the list in order and accept the first and second request.
However, the third request should be rejected since we have reached our limit of 2.
The expected answer is therefore the request ID of the third request i.e. **[30]**


###  Example 3

**requests**:
```
[
    "1 172.253.115.138 50000",
    "2 172.253.115.138 50900",
    "3 172.253.115.138 51000",
    "4 172.253.115.138 51500"
]
```
**limit_per_second**: 2

We accept the first and second requests. The third request is also accepted as 1000ms has elapsed since the first request.
The fourth request, however, must be rejected as we have accepted two requests from this IP with timestamps within a second of this request, namely request 2 and 3.
The expected answer is therefore the request ID of the fourth request i.e. **[4]**

## Important Assumptions
+ You can assume that requests will be **sorted by timestamp** in nondecreasing order.
+ The number of requests in any one test case will not exceed 200000.
+ No two request ids will be the same.
+ Different request ids may have the same IP address and timestamp. In such cases, we process the input list in the provided order to decide which request id to accept/reject. The second example above illustrates this case.
+ You can assume that the timestamp for each request fits in a 64-bit integer.
+ You can assume that limit_per_second and request_id for all requests fit in a 32-bit integer.
+ You can assume that the IP address will be a string containing only numbers and dots.


# Solution

The given solution take into account consideration that the idea is:
get array of all rejected requests, rejected requests are any requests made more that **limit_per_second** times
during last second (i.e. now() - 1 second (excluding)), where now is given request time).
F.e. for 2 requests per second:

[
    00_000,
    
    00_100,
    
    00_500, <- skip as during last second (-500ms; 500ms] it's 3rd request
    
    01_000, <- don't skip as during last second (0ms; 1_000ms] it's 2nd not declined request (0_000 is not inclusive and 00_500 wasn't counted as it's been rejected)
    
    01_000, <- skip as during last second (0ms; 1_000ms] it's 3rd request, i.e 01_000, 00_100 were included
    
    01_900, <- don't skip as during last second (00_900ms; 01_900ms] it's 2nd not declined request (second 01_000 was declined)
]
