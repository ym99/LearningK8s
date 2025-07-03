using System.Text.Json.Serialization;

public class SampleAppModel
{
    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;
}
