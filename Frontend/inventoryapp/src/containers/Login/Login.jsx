import React, { useState } from "react";
import { Input } from "../../components/Input/Input";
import toro from "../../assets/toro.png";
import "./Login.css";
import { Link } from "react-router-dom";
import { Button } from "../../components/Button/Button";
import { useNavigate } from "react-router-dom";
export const Login = () => {
  const navigate = useNavigate()
  const [Form, setForm] = useState({
    password: "",
    email: "",
  });
  const onChange = ({ target }, name) => {
    setForm({
      ...Form,
      [name]: target.value,
    });
  };

  const onSubmit = (e) => {
    e.preventDefault();
    console.log(Form);
    if(Form.email === 'diego@gmail.com' && Form.password === '123') navigate('/dashboard')
    else {
      alert('Intruso')
    }
    
  };
  return (
    <div className='container'>
      <div className='login'>
        <img src={toro} display='block' width='150px' alt='LogoToro' />
        <div className='logincontainer'>
          <h1>Inicia sesión en tu cuenta</h1>
          <p>
            o <Link to={"/dashboard"}>contacta con el administrador</Link>
          </p>
          <form onSubmit={onSubmit} id='loginform'>
            <Input
              label={"Correo electronico"}
              type={"email"}
              onChange={(e) => onChange(e, "email")}
            />
            <Input
              label={"Contraseña"}
              type={"password"}
              onChange={(e) => onChange(e, "password")}
            />
            <Link to={"/dashboard"}>¿Olvidaste tu contraseña?</Link>
            <Button
              herarchy={"primary"}
              title={"Iniciar Sesión"}
              type={"submit"}
            />
          </form>
        </div>
        <div className='buttoncontainer'>
          <Link to={'/dashboard'}>
            <Button
              herarchy={"secondary"}
              title={"Registrar Institución"}
            />
          </Link> 
        </div>
      </div>
      <div className='image'></div>
    </div>
  );
};
