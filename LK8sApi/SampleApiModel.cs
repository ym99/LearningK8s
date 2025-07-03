using System.Text.Json.Serialization;

namespace LK8sApi;

public class SampleApiModel
{
    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;

    [JsonPropertyName("callToApp")]
    public string CallToApp { get; set; } = string.Empty;
}
