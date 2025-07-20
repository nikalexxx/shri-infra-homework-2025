import React from "react";
import { Helmet } from "react-helmet";
import { cn } from "@bem-react/classname";

const bem = cn("About");
//Исправлено имя автора
export const About: React.FC = () => {
	return (
		<div className={bem()}>
			<Helmet title="About" />
			<div className="row">
				<div className="col">
					<h1>About</h1>
					<p>Author:</p>
				</div>
			</div>
		</div>
	);
};
