using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace LK8sApi.Controllers;

[ApiController]
[Route("[controller]")]
public class SampleApiController : ControllerBase
{
    private readonly ILogger<SampleApiController> _logger;
    private readonly HttpClient _httpClient;

    public SampleApiController(ILogger<SampleApiController> logger)
    {
        _logger = logger;
        _httpClient = new HttpClient();
    }

    [HttpGet(Name = "GetSampleApiModel")]
    public async Task<SampleApiModel> GetAsync()
    {
        var sampleAppModel = await GetSampleAppModelAsync();

        var result = new SampleApiModel
        {
            Name = "Sample API Model",
            CallToApp = sampleAppModel.Name
        };

        return result;
    }

    public async Task<SampleAppModel> GetSampleAppModelAsync()
    {
        var response = await _httpClient.GetAsync("http://localhost:5002/SampleApp");
        response.EnsureSuccessStatusCode();
        
        var json = await response.Content.ReadAsStringAsync();
        return JsonSerializer.Deserialize<SampleAppModel>(json) ?? new SampleAppModel
        {
            Name = "Call failed"
        };
    }
}
