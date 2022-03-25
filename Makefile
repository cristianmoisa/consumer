PACT_CLI="docker run --rm -v ${PWD}:${PWD} -e PACT_BROKER_BASE_URL pactfoundation/pact-cli"
PACTICIPANT := "ProductCatalogue"

pact:
	mvn test

can_i_deploy:
	"${PACT_CLI}" broker can-i-deploy --pacticipant ${PACTICIPANT} --version ${GIT_COMMIT} --to-environment production

record_deployment:
	@"${PACT_CLI}" broker record_deployment --pacticipant ${PACTICIPANT} --version ${GIT_COMMIT} --environment production

publish_pacts:
	@"${PACT_CLI}" publish ${PWD}/dsch-adstore-api/target/pacts --consumer-app-version ${GIT_COMMIT} --tag some-tag
