using System.Text.Json.Serialization;

namespace LK8sApp;

public class SampleAppModel
{
    [JsonPropertyName("info")]
    public string Info { get; set; } = string.Empty;
}
