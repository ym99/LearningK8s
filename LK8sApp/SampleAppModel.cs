using System.Text.Json.Serialization;

namespace LK8sApp;

public class SampleAppModel
{
    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;
}
