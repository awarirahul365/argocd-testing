#volumeapproach.ps1

try {
    docker info | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Docker Engine is running."
    } else {
        Write-Output "Docker Engine is not running.Run docker engine in background"
        exit 1
    }
} catch {
    Write-Output "Docker Engine is not running.Run docker engine in background and ensure its installed"
    exit 1
}
# For Testing locally in Docker Engine/Desktop
if(Test-Path ./docker-compose.yml){
    Write-Output "Docker-compose file present"
    Write-Output "Building and starting service"
    docker compose up --build -d
    Write-Output "Container Created Can test in Docker Desktop"
    Write-Output "Creating Container in Docker Desktop"
    Start-Sleep -Seconds 10
    Invoke-WebRequest -Uri "http://localhost:8080" 
    Invoke-WebRequest -Uri "http://localhost:9000"
    Start-Process 'http://localhost:8080/api/HttpTriggerReader?json=[{"id":"1","message":"Hello World"}]'
    Start-Process "http://localhost:9000/api/HttpTriggerReverse" 
}
else{
    Write-Output "Docker-compose file not present"
}
# For deployment to Kuberenetes cluster
$minikubeinstalled=Get-Command minikube -ErrorAction SilentlyContinue
if($minikubeinstalled){
    Write-Output "Minikube is installed"
    Start-Process "minikube" -ArgumentList "start" -NoNewWindow -Wait

    Start-Sleep -Seconds 20
    Write-Output "Minikube is now running."
    $deploykubernetescript={
        $kubernetesyamllist=@(
            'readercontainer-deployment.yaml',
            'readercontainer-service.yaml',
            'reversecontainer-deployment.yaml',
            'reversecontainer-service.yaml',
            'shared-data-persistentvolumeclaim.yaml'
        )
        foreach($yamlfile in $kubernetesyamllist){
            kubectl apply -f $yamlfile
        }
    }
    
    Start-Process "powershell.exe" -ArgumentList "-NoProfile", "-NoExit", "-Command",$deploykubernetescript
    Start-Process "powershell.exe" -ArgumentList "minikube service readercontainer"
    Start-Process "powershell.exe" -ArgumentList "minikube service reversecontainer"
}
else {
    Write-Output "Minikube is not installed"
}
