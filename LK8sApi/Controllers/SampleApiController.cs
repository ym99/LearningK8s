using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace LK8sApi.Controllers;

[ApiController]
[Route("/")]
public class SampleApiController : ControllerBase
{
    private readonly ILogger<SampleApiController> _logger;
    private readonly HttpClient _httpClient;

    public SampleApiController(ILogger<SampleApiController> logger)
    {
        _logger = logger;
        _httpClient = new HttpClient();
    }

    [HttpGet]
    public async Task<SampleApiModel> GetAsync()
    {
        var sampleAppModel = await GetSampleAppModelAsync();

        var result = new SampleApiModel
        {
            Info = $"API v4 call at {DateTime.Now}",
            AppInfo = sampleAppModel.Info
        };

        return result;
    }

    public async Task<SampleAppModel> GetSampleAppModelAsync()
    {
        var sampleAppUrl = Environment.GetEnvironmentVariable("LK8S_APP_URL") ?? "http://localhost:5002";
       
        var response = await _httpClient.GetAsync(sampleAppUrl);
        response.EnsureSuccessStatusCode();
        
        var json = await response.Content.ReadAsStringAsync();
        return JsonSerializer.Deserialize<SampleAppModel>(json) ?? new SampleAppModel
        {
            Info = $"Call failed {DateTime.Now}"
        };
    }
}
