#pgm 4
import numpy as np
import matplotlib.pyplot as plt
from tensorflow.keras import layers, models
from tensorflow.keras.datasets import mnist

# Load, normalise, flatten 28x28 -> 784
(x_train, _), (x_test, _) = mnist.load_data()
x_train = x_train.reshape(-1, 784) / 255.0
x_test = x_test.reshape(-1, 784) / 255.0

# Encoder (784 -> 64) and Decoder (64 -> 784)
inp = layers.Input(shape=(784,))
encoded = layers.Dense(64, activation="relu")(inp)          # compressed form
decoded = layers.Dense(784, activation="sigmoid")(encoded)  # reconstruction

autoencoder = models.Model(inp, decoded)
encoder = models.Model(inp, encoded)

autoencoder.compile(optimizer="adam", loss="binary_crossentropy")
autoencoder.fit(x_train, x_train, epochs=10, batch_size=256,validation_data=(x_test, x_test))

# Compress and reconstruct test images
compressed = encoder.predict(x_test[:5])
reconstructed = autoencoder.predict(x_test[:5])

# Show: original / compressed / reconstructed
plt.figure(figsize=(10, 5))
for i in range(5):
    plt.subplot(3, 5, i + 1)
    plt.imshow(x_test[i].reshape(28, 28), cmap="gray"); plt.title("Original"); plt.axis("off")
    plt.subplot(3, 5, i + 6)
    plt.imshow(compressed[i].reshape(8, 8), cmap="gray"); plt.title("Compressed"); plt.axis("off")
    plt.subplot(3, 5, i + 11)
    plt.imshow(reconstructed[i].reshape(28, 28), cmap="gray"); plt.title("Reconstructed"); plt.axis("off")
plt.tight_layout()
plt.show()
