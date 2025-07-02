using Microsoft.AspNetCore.Mvc;

namespace LK8sApi.Controllers;

[ApiController]
[Route("[controller]")]
public class SampleApiController : ControllerBase
{
    private readonly ILogger<SampleApiController> _logger;

    public SampleApiController(ILogger<SampleApiController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "GetSampleApiModel")]
    public SampleApiModel Get()
    {
        var result = new SampleApiModel
        {
            Name = "Sample API Model"
        };

        return result;
    }
}
