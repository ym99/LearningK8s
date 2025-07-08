using Microsoft.AspNetCore.Mvc;
using StackExchange.Redis;

namespace LK8sApp.Controllers;

[ApiController]
[Route("/")]
public class SampleAppController : ControllerBase
{
    const string KeyName = "lk8s-app:counter";

    private readonly ILogger<SampleAppController> _logger;

    public SampleAppController(ILogger<SampleAppController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public async Task<SampleAppModel> Get()
    {
        var redisValue = await GetRedisValueAsync();

        var result = new SampleAppModel
        {
            Info = $"App call at {DateTime.Now} with {redisValue}",
        };

        return result;
    }

    private async Task<string> GetRedisValueAsync()
    {
        var redisUrl = Environment.GetEnvironmentVariable("REDIS_URL") ?? "localhost:6379";
        Console.WriteLine($"********* Connecting to Redis at {redisUrl}");
        var redis = ConnectionMultiplexer.Connect(redisUrl);
        var db = redis.GetDatabase();

        await Task.WhenAll
        (
            Enumerable
                .Range(1, 1000)
                .AsParallel()
                .Select(_ =>
                    {
                        var increment = DateTime.Now.Millisecond % 100;
                        var result = db.StringIncrementAsync(KeyName, increment);

                        return result;
                    })
                .ToArray()
        );

        return db.StringGet(KeyName).ToString();
    }
}
