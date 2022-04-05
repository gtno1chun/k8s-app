resource "vault_generic_secret" "example-test" {
  path = "spinnaker-test"
  
  data_json = <<EOT
{
	"kubernetes": {
		"enabled": true,
		"accounts": [
			{
				"name": "jackchun-eks-37Xf",
				"requiredGroupMembership": [],
				"providerVersion": "V2",
				"permissions": {},
				"dockerRegistries": [],
				"configureImagePullSecrets": true,
				"cacheThreads": 1,
				"namespaces": [],
				"omitNamespaces": [
					"kube-system",
					"test-spin"
				],
				"kinds": [],
				"omitKinds": [],
				"customResources": [],
				"cachingPolicies": [],
				"kubeconfigContents": "apiVersion: v1\nclusters:\n- cluster:\n    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeU1EUXdOREF3TVRZeE1Wb1hEVE15TURRd01UQXdNVFl4TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS1R4CnFVdC9qMEdEYUtWeWFRalJXRy9jM2FXdlkyNS90bDRLV3h4MU80OUhoUWNxMU1lZG9TN2JXSmxYanFKK2pnVlAKOEwrdFBIbU4yTVZMYkZZaXRySEltS1UvREpiNEl0cjNIRTRJWDNNZnA1S290TENhQlEzM1NSckdRaktRcFFFNQp5TVN2ZEdCMUJySjlvREJNeUh4Tzcrd2NFQmFjRjJIeXZxQ2ZjZThmc01EdDh3YTBydkRpeWdjbTByYUxlOE82ClBDSWl3cUNHQ01oN3lpbVhZUUZXWFFERVJOSElpZWtGM2VEWm9QYmlpNkJ2OWFybkRRNCtEOWp0alpPRDF2anIKVElISEZYSGpxbUl4YTdOeTl0Q2J4d3RMOGlOdXVOSWovOTFjWkFVYmlqQnc3TGJRZVE4djRwTkIwR0RFZEZpVAo1b1E1ZDB5aFBVcUJVZ2NkRW9VQ0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZBN0xFQkY0amJYUlFJZFE1SHhYYkJWT1FMVXlNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFDVnZadUpGd0VmMTU0OUNyUHIxeEQzS1J3TTN6S1N5c2gxKzMveHkxc0d4WmNyZGJxeApvVGx6cXpUUStHeVY5Qm55VmNGZW1hdVBZR1NJN21KZHB2UVNqUDI1b3V0U3NTVExqMnZVdVFFRXR0V1lkRnY5Ci95ZUJabzN1NlpGZzNkVmdLL1VqMkJCUnE5M3VEK1RGaVJwN05kQU1ISG9NVG5vT090RFp0UHpkUVJNSU4rUUMKazVRaGRWYThFa0s5STQ0VUNvUkl5SW5xdlRsTzVNWmlzaXFaWUpXQk5YUUpjYjVTYUNiSXZnaWU1UkNuMjdsWgpTbm1wWkdFcm42T2twTEV1VkpodEZkQ0JPTFZYQjdKTUVxOExsYWRHeTdYM0tmRi82MU01THpsMWxVZlBpQVd0CmluVm5kUkVWaGxYbDJsN3lhenJ4bW5xZGxVYlpVbzlOWjNteAotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==\n    server: https://BA1D91A6899039B8E8ED0202A98EABD9.yl4.ap-northeast-2.eks.amazonaws.com\n  name: arn:aws:eks:ap-northeast-2:481230465846:cluster/jackchun-eks-37Xf\ncontexts:\n- context:\n    cluster: arn:aws:eks:ap-northeast-2:481230465846:cluster/jackchun-eks-37Xf\n    user: jackchun-eks-37Xf-token-user\n  name: jackchun-eks-37Xf\ncurrent-context: jackchun-eks-37Xf\nkind: Config\npreferences: {}\nusers:\n- name: arn:aws:eks:ap-northeast-2:481230465846:cluster/jackchun-eks-37Xf\n  user:\n    exec:\n      apiVersion: client.authentication.k8s.io/v1alpha1\n      args:\n      - --region\n      - ap-northeast-2\n      - eks\n      - get-token\n      - --cluster-name\n      - jackchun-eks-37Xf\n      command: aws\n      env:\n      - name: AWS_PROFILE\n        value: eks\n      interactiveMode: IfAvailable\n      provideClusterInfo: false\n- name: jackchun-eks-37Xf-token-user\n  user:\n    token: eyJhbGciOiJSUzI1NiIsImtpZCI6Ikc4djNUTEU5R1lGaFYySHJKX2UxXzJzRjAzQzlEbWVwX3RwUWVPSUhrTG8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJzcGlubmFrZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoic3Bpbm5ha2VyLXNlcnZpY2UtYWNjb3VudC10b2tlbi10Y3N4biIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJzcGlubmFrZXItc2VydmljZS1hY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiOWM1MDI3OTUtN2ZkYS00ZTU0LTlhM2QtNzAyMjZlNDIwM2Y3Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OnNwaW5uYWtlcjpzcGlubmFrZXItc2VydmljZS1hY2NvdW50In0.mL-Ry_JE_3MjotcQJyIlzicU20ySbZleH0VZiqlSZGKrNzgzOiQnEKTyEL55wkJC0NcHuNiT7KXXzpKBreou4GeN19n3RgMfMcxX94KiLGB01fXXxEGj7yF-8hHGVz-FnE8mqqdWZ6UKhGzaEr_WrojEv7zw6_-rAkfiMz140hK57kcNaXOi5fmw2TbOmJnZqTq89ESKFgvCjrZNKRvp7oxCqkAeZBqjX0Oau08WzUeIUjJGB55WGIQnkxzAEeyUkZF3gCuDiuOrJekR0WN7GuCmNI8G-F05Q7j8VTZ1rjvGIR11xCeMYX6LojRhgCH-7cjuDBI3DK_ltSmHCUA25Q"
			}
		]
	}
}
EOT

}