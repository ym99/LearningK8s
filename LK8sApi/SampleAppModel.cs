using System.Text.Json.Serialization;

public class SampleAppModel
{
    [JsonPropertyName("info")]
    public string Info { get; set; } = string.Empty;
}
