using System.Text.Json.Serialization;

namespace LK8sApi;

public class SampleApiModel
{
    [JsonPropertyName("info")]
    public string Info { get; set; } = string.Empty;

    [JsonPropertyName("appInfo")]
    public string AppInfo { get; set; } = string.Empty;
}
