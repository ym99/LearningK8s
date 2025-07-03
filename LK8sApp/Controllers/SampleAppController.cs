using Microsoft.AspNetCore.Mvc;

namespace LK8sApp.Controllers;

[ApiController]
[Route("[controller]")]
public class SampleAppController : ControllerBase
{
    private readonly ILogger<SampleAppController> _logger;

    public SampleAppController(ILogger<SampleAppController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "GetSampleAppModel")]
    public SampleAppModel Get()
    {
        var result = new SampleAppModel
        {
            Name = "Sample App Model"
        };

        return result;
    }
}
