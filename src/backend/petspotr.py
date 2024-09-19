from dapr.clients import DaprClient
from IPython.display import Image
from azure.ai.ml.dsl import pipeline
from azure.ai.ml import MLClient
from azure.identity import DefaultAzureCredential, InteractiveBrowserCredential
from azure.ai.ml.entities import CommandComponent, PipelineComponent, Job, Component
from azure.ai.ml import PyTorchDistribution, Input
from azure.ai.ml.constants import AssetTypes
from azure.ai.ml.entities import Data
from azure.ai.ml.constants import AssetTypes, InputOutputModes
from azure.ai.ml import Input
import json
import requests
import os

storage_account = os.environ.get('STORAGE_ACCOUNT', '')
region = os.environ.get('REGION', '')

experiment_name = (
    "AzureML-Train-Finetune-Vision-MultiClass-Samples"
)

score_threshold = 0.7

credential = DefaultAzureCredential()
workspace_ml_client = None

'''
------------------------------------------------------------------------------------------------------------------------
NOTE: The following code is commented out due to features not yet publicly available in the Azure ML SDK for Python.
Stay tuned for updates as Azure ML and Hugging Face features become more widely available
------------------------------------------------------------------------------------------------------------------------
'''

email_body = """
<img src="petspotr.io/static/logo.png" />
"""
'''
try:
    workspace_ml_client = MLClient.from_config(credential)
    subscription_id = workspace_ml_client.subscription_id
    resource_group = workspace_ml_client.resource_group_name
    workspace_name = workspace_ml_client.workspace_name
except Exception as ex:
    print(ex)
    # Enter details of your AML workspace
    subscription_id = os.environ.get('SUBSCRIPTION_ID', '')
    resource_group = os.environ.get('RESOURCE_GROUP', '')
    workspace_name = os.environ.get('WORKSPACE_NAME' ,'')
    workspace_ml_client = MLClient(
        credential, subscription_id, resource_group, workspace_name
    )

registry_ml_client = MLClient(
    credential,
    subscription_id,
    resource_group,
    workspace_name
)

model_selector_cluster_name = None
finetune_cluster_name = None

@pipeline()
def create_pipeline(training_mltable_path, validation_mltable_path, pipeline_component_args):
    """Create pipeline."""
    pipeline_component_func = registry_ml_client.components.get(
        name="imageclassification_pipelinecomponent", label="latest"
    )
    pipeline_component: PipelineComponent = pipeline_component_func(
        compute_model_selector=model_selector_cluster_name,
        compute_finetune=finetune_cluster_name,
        train_mltable_path=Input(type=AssetTypes.MLTABLE, path=training_mltable_path),
        valid_mltable_path=Input(type=AssetTypes.MLTABLE, path=validation_mltable_path),
        **pipeline_component_args,
    )
'''

class pet:
    def __init__(self, ID, Name, Type, Breed, Images, State, OwnerEmail, Description):
        self.ID = ID
        self.Name = Name
        self.Type = Type
        self.Breed = Breed
        self.Images = Images
        self.State = State
        self.OwnerEmail = OwnerEmail
        self.Description = Description

    def train_model(self):
        print('Training model')
        # Existing code...

    def predict_image(self):
        print('Predicting image')
        # Existing code...

    def alert_owner(self, dapr_client: DaprClient):
        '''
        Temporarily commented out due to features not yet publicly available in the Azure ML SDK for Python.

        # Process images
        index = 0
        train_validation_ratio = 5
        validation_items = []
        train_items = []
        contents = []
        images = self.Images.split(',')
        for image in images:
            url = f'https://{storage_account}.blob.core.windows.net/images/{image}'
            json_line = {
                "image_url": url,
                "label": self.ID
            }
            if index % train_validation_ratio == 0:
                # validation annotation
                validation_items.append(json.dumps(json_line))
            else:
                # train annotation
                train_items.append(json.dumps(json_line))
            index += 1

            contents.append = (
                "paths:\n"
                "  - url: ./{0}\n"
                "transformations:\n"
                "  - read_json_lines:\n"
                "        encoding: utf8\n"
                "        invalid_lines: error\n"
                "        include_path_column: false\n"
                "  - convert_column_types:\n"
                "      - columns: image_url\n"
                "        column_type: stream_info"
                ).format(url)
        
        # Fine-tune model
        pipeline_component_args = {
            # model_selection_args
            "model_name": "microsoft/beit-base-patch16-224-pt22k-ft22k",
            # finetune_args
            "image_width": 224,
            "image_height": 224,
            "model_family": "HuggingFaceImage",
            "task_name": "ImageSingleLabelClassification",
            "apply_augmentations": "true",
            "dataloader_num_workers": 0,
            "apply_deepspeed": "false",
            "apply_ort": "false",
            "epochs": 15,
            "max_steps": -1,
            "train_batch_size": 4,
            "valid_batch_size": 4,
            "auto_find_batch_size": "false",
            "learning_rate": 1e-3,
            "lr_scheduler_type": "linear",
            "warmup_steps": 0,
            "optimizer": "adamw_hf",
            "weight_decay": 0.0,
            "weight_decay_sgd": 0.0,
            "momentum_sgd": 0.0,
            "gradient_accumulation_steps": 1,
            "precision": "32",
            "metric_for_best_model": "loss",
            "seed": 42,
            "evaluation_strategy": "epoch",
            "logging_strategy": "epoch",
            "logging_steps": 500,
            "save_total_limit": -1,
            "apply_early_stopping": "false",
            "early_stopping_patience": 1,
            "resume_from_checkpoint": "false",
            "save_as_mlflow_model": "false",
        }
        pipeline_object = create_pipeline(train_items, validation_items)
        pipeline_object.display_name = (
            pipeline_component_args["model_name"] + "_pipeline_component_run_" + "multiclass"
        )
        
        print("Submitting pipeline")
        pipeline_run = workspace_ml_client.jobs.create_or_update(
            pipeline_object, experiment_name=experiment_name
        )
        print(f"Pipeline created. URL: {pipeline_run.studio_url}")
        '''
        return

    def predict_image(self):
        print('Predicting image')
        '''
        Temporarily commented out due to features not yet publicly available in the Azure ML SDK for Python. For now this function returns True to simulate a successful prediction.
        # Load image
        image_path = f'https://{storage_account}.blob.core.windows.net/images/{image}'
        imageData = Image(url=image_path)

        payload = {
            "imageData": imageData,
            "breed": self.Breed
        }

        # Predict image
        result = requests.post(
            url=f'https://{workspace_name}.{region}.inference.ml.azure.com/score',
            data=json.dumps(payload)
        )

        if result.data['score'] >= score_threshold:
            return True
        else:
            return False
        '''
        return True

    def alert_owner(self, dapr_client: DaprClient):
        # Send email to owner
        email_contents = {
            "fromEmail": "petspotr@petspotr.io",
            "toEmail": self.OwnerEmail,
            "subject": f"🎉 New Match for {self.Name}!",
            "body": email_body
        }

        dapr_client.invoke_binding(
            binding_name='email',
            operation='create',
            data=json.dumps(email_contents)
        )

        return
