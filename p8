#pgm 8
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras import layers, models

# Load IMDB reviews (already converted to word-index numbers)
num_words, max_len = 10000, 200
(x_train, y_train), (x_test, y_test) = tf.keras.datasets.imdb.load_data(num_words=num_words)

# Pad every review to the same length
x_train = tf.keras.preprocessing.sequence.pad_sequences(x_train, maxlen=max_len)
x_test = tf.keras.preprocessing.sequence.pad_sequences(x_test, maxlen=max_len)

# Embedding -> Bi-LSTM -> Dense(sigmoid)
model = models.Sequential([
    layers.Input(shape=(max_len,)),
    layers.Embedding(num_words, 32),
    layers.Bidirectional(layers.LSTM(32)),
    layers.Dense(1, activation="sigmoid"),
])
model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])

# Train + evaluate
history = model.fit(x_train, y_train, epochs=3, batch_size=128, validation_data=(x_test, y_test))
loss, acc = model.evaluate(x_test, y_test, verbose=0)
print(f"Test Accuracy: {acc:.4f}")

# Predict one random review
i = np.random.randint(len(x_test))
p = model.predict(x_test[i:i+1], verbose=0)[0][0]
print("Predicted:", "Positive" if p > 0.5 else "Negative",
      "| Actual:", "Positive" if y_test[i] == 1 else "Negative")

# Accuracy graph
plt.plot(history.history["accuracy"], label="Train")
plt.plot(history.history["val_accuracy"], label="Validation")
plt.xlabel("Epoch"); plt.ylabel("Accuracy"); plt.legend(); plt.show()
