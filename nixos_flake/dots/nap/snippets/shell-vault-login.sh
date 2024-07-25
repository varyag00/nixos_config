vault_login() {
    local ENV=$1

    if [ "$ENV" = "staging" ]; then
        export VAULT_ADDR="https://foo.bar"
        export VAULT_NAMESPACE="bas"
        # maybe need to use -method=oidc
        export VAULT_TOKEN=$(vault login -token-only -ns="$VAULT_NAMESPACE")
    elif [ "$ENV" = "production" ]; then
        export VAULT_ADDR="https://foo.bar"
        export VAULT_NAMESPACE="bas"
        # maybe need to use -method=oidc
        export VAULT_TOKEN=$(vault login -token-only -ns="$VAULT_NAMESPACE")
    fi
}
