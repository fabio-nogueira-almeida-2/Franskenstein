package com.frankenstein

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlin.math.roundToInt

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            FrankensteinApp()
        }
    }
}

@Composable
fun FrankensteinApp() {
    var selectedTab by remember { mutableStateOf(0) }
    
    Column(
        modifier = Modifier.fillMaxSize()
    ) {
        // Top Navigation
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            Button(
                onClick = { selectedTab = 0 },
                colors = ButtonDefaults.buttonColors(
                    containerColor = if (selectedTab == 0) Color(0xFF6B46C1) else Color.Gray
                ),
                modifier = Modifier.weight(1f)
            ) {
                Text("☕ Café", color = Color.White)
            }
            
            Spacer(modifier = Modifier.width(8.dp))
            
            Button(
                onClick = { selectedTab = 1 },
                colors = ButtonDefaults.buttonColors(
                    containerColor = if (selectedTab == 1) Color(0xFF6B46C1) else Color.Gray
                ),
                modifier = Modifier.weight(1f)
            ) {
                Text("⛽ Gasolina", color = Color.White)
            }
        }
        
        // Content
        when (selectedTab) {
            0 -> CoffeeScreen()
            1 -> GasScreen()
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CoffeeScreen() {
    var formula by remember { mutableStateOf("10") }
    var water by remember { mutableStateOf("") }
    var coffee by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(
                brush = Brush.verticalGradient(
                    colors = listOf(
                        Color(0xFF6B46C1), // Purple
                        Color(0xFF4F46E5)  // Indigo
                    )
                )
            )
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Header
        Text(
            text = "☕",
            fontSize = 80.sp,
            modifier = Modifier.padding(16.dp)
        )
        
        Text(
            text = "Café 1:10",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            color = Color.White,
            textAlign = TextAlign.Center
        )
        
        Spacer(modifier = Modifier.height(32.dp))
        
        // Input Fields
        OutlinedTextField(
            value = formula,
            onValueChange = { formula = it },
            label = { Text("Proporção (1:x)", color = Color.White) },
            modifier = Modifier.fillMaxWidth(),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            colors = TextFieldDefaults.outlinedTextFieldColors(
                focusedBorderColor = Color.White,
                unfocusedBorderColor = Color.White.copy(alpha = 0.7f)
            )
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        OutlinedTextField(
            value = water,
            onValueChange = { water = it },
            label = { Text("Água (ml)", color = Color.White) },
            modifier = Modifier.fillMaxWidth(),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            colors = TextFieldDefaults.outlinedTextFieldColors(
                focusedBorderColor = Color.White,
                unfocusedBorderColor = Color.White.copy(alpha = 0.7f)
            )
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        OutlinedTextField(
            value = coffee,
            onValueChange = { coffee = it },
            label = { Text("Café (gr)", color = Color.White) },
            modifier = Modifier.fillMaxWidth(),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            colors = TextFieldDefaults.outlinedTextFieldColors(
                focusedBorderColor = Color.White,
                unfocusedBorderColor = Color.White.copy(alpha = 0.7f)
            )
        )
        
        Spacer(modifier = Modifier.height(32.dp))
        
        // Buttons
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            Button(
                onClick = {
                    formula = "10"
                    water = ""
                    coffee = ""
                    result = ""
                },
                colors = ButtonDefaults.buttonColors(containerColor = Color.White),
                modifier = Modifier.weight(1f)
            ) {
                Text("Resetar", color = Color(0xFF6B46C1))
            }
            
            Spacer(modifier = Modifier.width(16.dp))
            
            Button(
                onClick = {
                    val f = formula.toDoubleOrNull() ?: 10.0
                    val w = water.toDoubleOrNull()
                    val c = coffee.toDoubleOrNull()
                    
                    result = when {
                        w != null && c == null -> {
                            val calculatedCoffee = w / f
                            coffee = calculatedCoffee.roundToInt().toString()
                            "Café: ${calculatedCoffee.roundToInt()}g"
                        }
                        c != null && w == null -> {
                            val calculatedWater = c * f
                            water = calculatedWater.roundToInt().toString()
                            "Água: ${calculatedWater.roundToInt()}ml"
                        }
                        w != null && c != null -> {
                            val ratio = w / c
                            "Proporção atual: 1:${ratio.roundToInt()}"
                        }
                        else -> "Preencha pelo menos um campo"
                    }
                },
                colors = ButtonDefaults.buttonColors(containerColor = Color.White),
                modifier = Modifier.weight(1f)
            ) {
                Text("Calcular", color = Color(0xFF6B46C1))
            }
        }
        
        Spacer(modifier = Modifier.height(24.dp))
        
        // Result
        if (result.isNotEmpty()) {
            Card(
                modifier = Modifier.fillMaxWidth(),
                colors = CardDefaults.cardColors(containerColor = Color.White.copy(alpha = 0.9f))
            ) {
                Text(
                    text = result,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF6B46C1),
                    textAlign = TextAlign.Center,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                )
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun GasScreen() {
    var alcoholValue by remember { mutableStateOf("") }
    var gasolineValue by remember { mutableStateOf("") }
    var result by remember { mutableStateOf("") }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(
                brush = Brush.verticalGradient(
                    colors = listOf(
                        Color.White,
                        Color(0xFFFF7F50), // Orange
                        Color(0xFFFF4500)  // Red
                    )
                )
            )
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Header
        Text(
            text = "⛽",
            fontSize = 80.sp,
            modifier = Modifier.padding(16.dp)
        )
        
        Text(
            text = "Gasolina x Álcool",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            color = Color.Black,
            textAlign = TextAlign.Center
        )
        
        Spacer(modifier = Modifier.height(32.dp))
        
        // Input Fields
        OutlinedTextField(
            value = alcoholValue,
            onValueChange = { alcoholValue = it },
            label = { Text("Álcool (R$)", color = Color.Black) },
            modifier = Modifier.fillMaxWidth(),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
            colors = TextFieldDefaults.outlinedTextFieldColors(
                focusedBorderColor = Color.Black,
                unfocusedBorderColor = Color.Black.copy(alpha = 0.7f)
            )
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        OutlinedTextField(
            value = gasolineValue,
            onValueChange = { gasolineValue = it },
            label = { Text("Gasolina (R$)", color = Color.Black) },
            modifier = Modifier.fillMaxWidth(),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
            colors = TextFieldDefaults.outlinedTextFieldColors(
                focusedBorderColor = Color.Black,
                unfocusedBorderColor = Color.Black.copy(alpha = 0.7f)
            )
        )
        
        Spacer(modifier = Modifier.height(32.dp))
        
        // Buttons
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            Button(
                onClick = {
                    alcoholValue = ""
                    gasolineValue = ""
                    result = ""
                },
                colors = ButtonDefaults.buttonColors(containerColor = Color.White),
                modifier = Modifier.weight(1f)
            ) {
                Text("Limpar", color = Color(0xFFFF4500))
            }
            
            Spacer(modifier = Modifier.width(16.dp))
            
            Button(
                onClick = {
                    val alcohol = alcoholValue.toDoubleOrNull()
                    val gasoline = gasolineValue.toDoubleOrNull()
                    
                    result = if (alcohol != null && gasoline != null) {
                        val ratio = alcohol / gasoline
                        if (ratio <= 0.7) {
                            "✅ Álcool vale a pena!\nProporção: ${String.format("%.2f", ratio)}"
                        } else {
                            "❌ Gasolina vale mais a pena!\nProporção: ${String.format("%.2f", ratio)}"
                        }
                    } else {
                        "Por favor, preencha ambos os campos"
                    }
                },
                colors = ButtonDefaults.buttonColors(containerColor = Color.White),
                modifier = Modifier.weight(1f)
            ) {
                Text("Calcular", color = Color(0xFFFF4500))
            }
        }
        
        Spacer(modifier = Modifier.height(24.dp))
        
        // Result
        if (result.isNotEmpty()) {
            Card(
                modifier = Modifier.fillMaxWidth(),
                colors = CardDefaults.cardColors(containerColor = Color.White.copy(alpha = 0.9f))
            ) {
                Text(
                    text = result,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFFFF4500),
                    textAlign = TextAlign.Center,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp)
                )
            }
        }
    }
} 