using Dapr.Client;
using Microsoft.Extensions.Logging;

namespace PetSpotR.Models 
{
    public class PetModel
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Breed { get; set; }
        public string ID { get; set; }
        public string State { get; set; }
        public List<string> Images { get; set; }
        private readonly ILogger<PetModel> _logger;

        // Constructor
        public PetModel()
        {
            Name = "";
            Type = "";
            Breed = "";
            ID = Guid.NewGuid().ToString();
            State = "new";
            Images = new();
        }

        public async Task SavePetStateAsync(DaprClient daprClient, string storeName)
        {
            try {
                //Logger.LogInformation("Saving state");
                await daprClient.SaveStateAsync(
                    storeName: storeName,
                    key: ID,
                    value: new Dictionary<string, string>
                    {
                        { "petName", Name },
                        { "petType", Type },
                        { "petBreed", Breed },
                        { "petId", ID },
                        { "petState", State },
                        { "petImages", string.Join(",", Images) }
                }
            );
            } catch (Exception ex) {
                //Logger.LogError("Error: {Error}", ex.InnerException);
                throw ex;
            }

            return;
        }

        public async Task PublishLostPetAsync(DaprClient daprClient, string pubsubName)
        {
            try {
                // Logger.LogInformation("Publishing event");
                await daprClient.PublishEventAsync(
                    pubsubName: pubsubName,
                    topicName: "lostPet",
                    data: new Dictionary<string, string>
                    {
                        { "petId", ID }
                    }
                );
            } catch (Exception ex) {
                // Logger.LogError("Error: {Error}", ex.InnerException);
                throw ex;
            }

            return;
        }
    }
}
