# Log Likelyhood: Higher the better
print("Log Likelihood: ", lda_model.score(tokens))

# Perplexity: Lower the better. Perplexity = exp(-1. * log-likelihood per word)
print("Perplexity: ", lda_model.perplexity(tokens))

# See model parameters
pprint(lda_model.get_params())